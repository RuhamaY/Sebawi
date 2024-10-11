"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PostsService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("mongoose");
const mongoose_2 = require("@nestjs/mongoose");
let PostsService = class PostsService {
    constructor(postsModel) {
        this.postsModel = postsModel;
    }
    async createPosts(createPostsDto) {
        try {
            const newPosts = new this.postsModel({
                ...createPostsDto,
            });
            return await newPosts.save();
        }
        catch (error) {
            throw new Error('Failed to create post: ' + error.message);
        }
    }
    async readPosts() {
        return this.postsModel.find({})
            .then((posts) => { return posts; })
            .catch((err) => console.log(err));
    }
    async findAll(query) {
        const posts = await this.postsModel.find();
        return posts;
    }
    async findMyPosts(userId) {
        return this.postsModel.find({ user: userId }).exec();
    }
    async findById(id) {
        const isValidID = mongoose_1.default.isValidObjectId(id);
        const posts = await this.postsModel.findById(id);
        if (!isValidID) {
            throw new common_1.BadRequestException('Please enter correct id!');
        }
        if (!posts) {
            throw new common_1.NotFoundException('Posts not found!');
        }
        return posts;
    }
    async updatePosts(id, posts) {
        return await this.postsModel.findByIdAndUpdate(id, posts, { new: true, runValidators: true, });
    }
    async deletePosts(postsId) {
        const result = await this.postsModel.deleteOne({ _id: postsId }).exec();
        if (result.deletedCount === 0) {
            throw new common_1.NotFoundException('Post not found');
        }
    }
};
exports.PostsService = PostsService;
exports.PostsService = PostsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_2.InjectModel)('posts')),
    __metadata("design:paramtypes", [mongoose_1.Model])
], PostsService);
//# sourceMappingURL=posts.service.js.map